# Keep HTTP client classes
-keep class okhttp3.** { *; }
-keep class okhttp3.internal.** { *; }

# Keep JSON parsing libraries
-keep class com.google.gson.** { *; }
-keep class org.json.** { *; }

# Keep attributes for reflection
-keepattributes Signature
-keepattributes *Annotation*
