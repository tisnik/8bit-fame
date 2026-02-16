; ModuleID = 'simd_dot_product.c'
source_filename = "simd_dot_product.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local float @dot_fp16(<8 x half> noundef %0, <8 x half> noundef %1) local_unnamed_addr #0 {
  %3 = extractelement <8 x half> %0, i64 0
  %4 = fpext half %3 to float
  %5 = extractelement <8 x half> %1, i64 0
  %6 = fpext half %5 to float
  %7 = extractelement <8 x half> %0, i64 1
  %8 = fpext half %7 to float
  %9 = extractelement <8 x half> %1, i64 1
  %10 = fpext half %9 to float
  %11 = fmul float %8, %10
  %12 = tail call float @llvm.fmuladd.f32(float %4, float %6, float %11)
  %13 = extractelement <8 x half> %0, i64 2
  %14 = fpext half %13 to float
  %15 = extractelement <8 x half> %1, i64 2
  %16 = fpext half %15 to float
  %17 = tail call float @llvm.fmuladd.f32(float %14, float %16, float %12)
  %18 = extractelement <8 x half> %0, i64 3
  %19 = fpext half %18 to float
  %20 = extractelement <8 x half> %1, i64 3
  %21 = fpext half %20 to float
  %22 = tail call float @llvm.fmuladd.f32(float %19, float %21, float %17)
  %23 = extractelement <8 x half> %0, i64 4
  %24 = fpext half %23 to float
  %25 = extractelement <8 x half> %1, i64 4
  %26 = fpext half %25 to float
  %27 = tail call float @llvm.fmuladd.f32(float %24, float %26, float %22)
  %28 = extractelement <8 x half> %0, i64 5
  %29 = fpext half %28 to float
  %30 = extractelement <8 x half> %1, i64 5
  %31 = fpext half %30 to float
  %32 = tail call float @llvm.fmuladd.f32(float %29, float %31, float %27)
  %33 = extractelement <8 x half> %0, i64 6
  %34 = fpext half %33 to float
  %35 = extractelement <8 x half> %1, i64 6
  %36 = fpext half %35 to float
  %37 = tail call float @llvm.fmuladd.f32(float %34, float %36, float %32)
  %38 = extractelement <8 x half> %0, i64 7
  %39 = fpext half %38 to float
  %40 = extractelement <8 x half> %1, i64 7
  %41 = fpext half %40 to float
  %42 = tail call float @llvm.fmuladd.f32(float %39, float %41, float %37)
  ret float %42
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @dot_float(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = extractelement <4 x float> %0, i64 0
  %4 = extractelement <4 x float> %1, i64 0
  %5 = fmul <4 x float> %0, %1
  %6 = extractelement <4 x float> %5, i64 1
  %7 = tail call float @llvm.fmuladd.f32(float %3, float %4, float %6)
  %8 = extractelement <4 x float> %0, i64 2
  %9 = extractelement <4 x float> %1, i64 2
  %10 = tail call float @llvm.fmuladd.f32(float %8, float %9, float %7)
  %11 = extractelement <4 x float> %0, i64 3
  %12 = extractelement <4 x float> %1, i64 3
  %13 = tail call float @llvm.fmuladd.f32(float %11, float %12, float %10)
  ret float %13
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @dot_double(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = extractelement <2 x double> %0, i64 0
  %4 = extractelement <2 x double> %1, i64 0
  %5 = fmul <2 x double> %0, %1
  %6 = extractelement <2 x double> %5, i64 1
  %7 = tail call double @llvm.fmuladd.f64(double %3, double %4, double %6)
  ret double %7
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
