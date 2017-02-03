
file(READ ${INPUT} filecontent)
string(REPLACE "<jni.h>" "\"idl2jni_jni.h\"" filecontent "${filecontent}")
file(WRITE "${OUTPUT}" "${filecontent}")
