; ModuleID = 'simd_dot_product_2.c'
source_filename = "simd_dot_product_2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind optsize memory(none) uwtable
define dso_local float @dot_fp16(<8 x half> noundef %0, <8 x half> noundef %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %2, %3
  %4 = phi half [ 0xH0000, %2 ], [ %12, %3 ]
  %5 = phi i32 [ 0, %2 ], [ %13, %3 ]
  %6 = extractelement <8 x half> %0, i32 %5
  %7 = fpext half %6 to float
  %8 = extractelement <8 x half> %1, i32 %5
  %9 = fpext half %8 to float
  %10 = fpext half %4 to float
  %11 = tail call float @llvm.fmuladd.f32(float %7, float %9, float %10)
  %12 = fptrunc float %11 to half
  %13 = add nuw nsw i32 %5, 1
  %14 = icmp eq i32 %13, 8
  br i1 %14, label %15, label %3, !llvm.loop !3

15:                                               ; preds = %3
  %16 = fpext half %12 to float
  ret float %16
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: nofree norecurse nosync nounwind optsize memory(none) uwtable
define dso_local float @dot_float(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %2, %3
  %4 = phi float [ 0.000000e+00, %2 ], [ %8, %3 ]
  %5 = phi i32 [ 0, %2 ], [ %9, %3 ]
  %6 = extractelement <4 x float> %0, i32 %5
  %7 = extractelement <4 x float> %1, i32 %5
  %8 = tail call float @llvm.fmuladd.f32(float %6, float %7, float %4)
  %9 = add nuw nsw i32 %5, 1
  %10 = icmp eq i32 %9, 4
  br i1 %10, label %11, label %3, !llvm.loop !5

11:                                               ; preds = %3
  ret float %8
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @dot_double(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #2 {
  %3 = extractelement <2 x double> %0, i64 0
  %4 = extractelement <2 x double> %1, i64 0
  %5 = tail call double @llvm.fmuladd.f64(double %3, double %4, double 0.000000e+00)
  %6 = extractelement <2 x double> %0, i64 1
  %7 = extractelement <2 x double> %1, i64 1
  %8 = tail call double @llvm.fmuladd.f64(double %6, double %7, double %5)
  ret double %8
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

attributes #0 = { nofree norecurse nosync nounwind optsize memory(none) uwtable "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+avx,+cmov,+crc32,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+avx,+cmov,+crc32,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.mustprogress"}
!5 = distinct !{!5, !4}
