; ModuleID = 'simd_9.c'
source_filename = "simd_9.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-i128:128-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @neg(<4 x i32> noundef %0) local_unnamed_addr #0 {
  %2 = sub <4 x i32> zeroinitializer, %0
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @add(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = add <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @sub(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = sub <4 x i32> %0, %1
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @mul(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = mul <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @div(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = udiv <4 x i32> %0, %1
  ret <4 x i32> %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+bulk-memory,+bulk-memory-opt,+call-indirect-overlong,+multivalue,+mutable-globals,+nontrapping-fptoint,+reference-types,+sign-ext,+simd128" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
