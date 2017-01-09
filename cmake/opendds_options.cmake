## this file must be included from the root of DDS project
set(OPENDDS_BASE_OPTIONS
    BUILT_IN_TOPICS
    CONTENT_SUBSCRIPTION
    QUERY_CONDITION
    CONTENT_FILTERED_TOPIC
    MULTI_TOPIC
    OWNERSHIP_PROFILE
    OWNERSHIP_KIND_EXCLUSIVE
    OBJECT_MODEL_PROFILE
    PERSISTENCE_PROFILE
)

foreach(opt ${OPENDDS_BASE_OPTIONS})
  option(${opt} "" ON)
endforeach()

if (NOT CONTENT_SUBSCRIPTION)
  set(QUERY_CONDITION OFF)
  set(CONTENT_FILTERED_TOPIC OFF)
  set(MULTI_TOPIC OFF)
endif()

if (NOT OWNERSHIP_PROFILE)
  # Currently there is no support for exclusion of code dealing with HISTORY depth > 1
  # therefore ownership_profile is the same as ownership_kind_exclusive.
  set(OWNERSHIP_KIND_EXCLUSIVE OFF)
endif()

option(NO_OPENDDS_SAFETY_PROFILE "" ON)
option(DDS_SUPPRESS_ANYS "" ON)

if (CONTENT_SUBSCRIPTION AND (QUERY_CONDITION OR CONTENT_FILTERED_TOPIC OR MULTI_TOPIC))
  set(CONTENT_SUBSCRIPTION_CORE TRUE)
endif()


set(DDS_OPTIONS ${OPENDDS_BASE_OPTIONS}
                OWNERSHIP_KIND_EXCLUSIVE
                DDS_SUPPRESS_ANYS
                NO_OPENDDS_SAFETY_PROFILE
                CONTENT_SUBSCRIPTION_CORE
                TAO_BASE_IDL_FLAGS
                DDS_BASE_IDL_FLAGS)

