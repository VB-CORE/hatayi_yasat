-keep public class com.android.gms.**

-keep class com.google.android.gms.measurement.internal.** { *; }
-keep class com.android.gms.** { *; }
-keepclassmembers class com.android.gms.* {
    <fields>;
    <init>();
    <methods>;
}
-keepclassmembers class com.android.gms.** { *; }