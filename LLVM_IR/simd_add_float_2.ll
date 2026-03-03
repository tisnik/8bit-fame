; ModuleID = 'simd_add_float_2.c'
source_filename = "simd_add_float_2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef <16 x half> @add_f16x8(<16 x half> noundef %0, <16 x half> noundef %1) local_unnamed_addr #0 {
  %3 = fadd <16 x half> %0, %1
  ret <16 x half> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef <8 x float> @add_f32x8(<8 x float> noundef %0, <8 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fadd <8 x float> %0, %1
  ret <8 x float> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef <4 x double> @add_f64x4(<4 x double> noundef %0, <4 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fadd <4 x double> %0, %1
  ret <4 x double> %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="256" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+avx,+cmov,+crc32,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
