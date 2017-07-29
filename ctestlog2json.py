#!/usr/bin/env python

import os
import re
import pprint
import shlex
import subprocess
import platform
import sys
import json
import argparse

start_time = ""

result = {'tests': []}

class PreOutputSectionProessor(object):
    def __init__(self, config):
        self.handlers = [
            [re.compile(r"(\d+)/\d+ Testing: (.+)"), 'testing_matched'],
            [re.compile(r"Command: (.+)"), 'command_matched'],
            [re.compile(r"Directory: (.+)"), 'directory_matched'],
        ]
        self.config = config
        self.test_info = None

    def testing_matched(self, match):
        self.test_info = { 'number': match.group(1), 'name': match.group(2).replace('__', ' '), 'output': []}

    def command_matched(self, match):
        self.test_info['command'] = ' '.join( map(lambda s: s if ' ' in s else re.sub(r'^"|"$', '', s),
                                                  shlex.split(match.group(1)) ))

    def directory_matched(self, match):
        self.test_info['directory'] = match.group(1)

    def process(self, line):
        for pattern, handler_name in self.handlers:
            m = pattern.match(line)
            if m:
                handler = getattr(self, handler_name)
                handler(m)
                break

    def next(self):
        return OutputSectionProcessor(self.config, self.test_info)

class OutputSectionProcessor(object):
    def __init__(self, config, test_info):
        self.config = config
        self.test_info = test_info
        self.end_of_output = False

    def process(self, line):
        if self.end_of_output:
            m = re.match(r"Test time =\s+(\S+)\s+sec", line)
            if m:
                self.test_info['test_time'] = m.group(1)
        elif line == "<end of output>":
            self.end_of_output = True
        else:
            self.test_info['output'].append(line)
    def next(self):
        return PostOutputSectionProdessor(self.config, self.test_info)

class PostOutputSectionProdessor(object):
    def __init__(self, config, test_info):
        self.config = config
        self.test_info = test_info
        self.handlers = [
            [re.compile(r"Test (.+)\."), 'status_matched']
        ]
    def status_matched(self, match):
        self.test_info['status'] = match.group(1)

    def process(self, line):
        for pattern, handler_name in self.handlers:
            m = pattern.match(line)
            if m:
                handler = getattr(self, handler_name)
                handler(m)
                break
    def next(self):
        if self.config.discard_passed_output and self.test_info['status']=='Passed':
            self.test_info.pop('output', None)
        else:
            filename = self.test_info['number']+ '.txt'
            with open(os.path.join(self.config.output_dir, filename), 'w') as f:
                f.write('\n'.join(self.test_info['output']))
            self.test_info['output'] = self.config.generated_url_prefix + filename
        result['tests'].append(self.test_info)
        return PreOutputSectionProessor(self.config)

class StartingProcessor(object):
    def __init__(self, config):
        self.config = config
        pass

    def next(self):
        return PreOutputSectionProessor(self.config)
    def process(self, line):
        m = re.match("Start testing: (.+)", line)
        if m:
            result['test_start_time'] = m.group(1)


def parse_cmake_cache():
    result = {}
    with open('CMakeCache.txt', 'r') as f:
        for line in f:
            line = line.strip()
            if len(line) == 0 or line.startswith('//') or line.startswith('#'):
                continue

            key_and_type, value = line.split('=')
            key, _type = key_and_type.split(':')
            result[key] = value
    return result



def linux_distribution():
  try:
    return platform.linux_distribution()
  except:
    return "N/A"

def get_system_info():
    return {
        'dist': str(platform.dist()),
        'linux_distribution': linux_distribution(),
        'system': platform.system(),
        'machine': platform.machine(),
        'platform': platform.platform(),
        'uname': platform.uname(),
        'version': platform.version(),
        'mac_ver': platform.mac_ver()
    }

def get_repo_info(dir):
    return{
        'origin': subprocess.check_output(["git", "remote", "get-url", "origin"], cwd=dir),
        'branch': os.getenv('TRAVIS_BRANCH') or subprocess.check_output(["git", "symbolic-ref", "--short", "HEAD"], cwd=dir),
        'commit': os.getenv('TRAVIS_COMMIT') or subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=dir),
        'message': os.getenv('TRAVIS_COMMIT_MESSAGE') or subprocess.check_output(["git", "log", "-1", "--pretty=%B"])
    }


def split_last_test_log(config):
    filename = config.lasttestlog or 'Testing/Temporary/LastTest.log'
    with open(filename, 'r') as in_file:
        processor = StartingProcessor(config)
        for line in in_file:
            if line == "----------------------------------------------------------\n":
                processor = processor.next()
            else:
                processor.process(line.strip())


def parse_args():
  parser = argparse.ArgumentParser(description='Process CTest LastTest.log and CMakeCache.txt.')
  parser.add_argument('--discard_passed_output', default=True,
                      help='Whether to keep passed test output')

  parser.add_argument('--output_dir', default='Testing/Report',
                      help='The output directory for processed result')

  parser.add_argument('--generated_url_prefix', default='',
                      help='The URL prefix for generated test log output file')

  parser.add_argument('--lasttestlog',
                      help='The path to input LastTest.log. When speicified, the program only split the log file.')

  return parser.parse_args()

def main():

   config = parse_args()

   if not os.path.exists(config.output_dir):
       os.makedirs(config.output_dir)
   split_last_test_log(config);

   if not config.lasttestlog:
     result['CMakeCache'] = parse_cmake_cache()
     result['repo'] = get_repo_info(result['CMakeCache']['CMAKE_HOME_DIRECTORY'])
     result['platform'] = get_system_info()
     result['matrix'] = os.getenv('MATRIX_NAME') or "Unknown"
     result['build_flags'] = os.getenv('DDS_BUILD_FLAGS') or ""

     with open(os.path.join(config.output_dir ,"tests.json"), 'w') as f:
         json.dump(result, f)


if __name__ == "__main__":
    main()
