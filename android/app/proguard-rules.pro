# Flutter WebRTC
-keep class com.cloudwebrtc.webrtc.** { *; }
-keep class org.webrtc.** { *; }
-keep class org.jni_zero.** { *; }

# Keep JNI methods (to avoid stripping native bindings)
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep attributes needed for reflection
-keepattributes Signature, InnerClasses, EnclosingMethod, SourceFile, LineNumberTable, Exceptions, Deprecated, RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations, AnnotationDefault

# Don’t shrink these (common issue with WebRTC peer connection classes)
-dontwarn org.webrtc.**
-dontwarn com.cloudwebrtc.webrtc.**
