# Firebase discovers its components by reflectively instantiating every
# ComponentRegistrar listed in the merged manifest, so R8 must not remove or
# rename their no-arg constructors.
-keep class * implements com.google.firebase.components.ComponentRegistrar {
    <init>();
}
-keepnames class com.google.firebase.components.ComponentRegistrar
