; ModuleID = 'simd_dot_product_int.c'
source_filename = "simd_dot_product_int.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local float @dot_i18x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %4 = sext <8 x i8> %3 to <8 x i32>
  %5 = shufflevector <16 x i8> %1, <16 x i8> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %6 = sext <8 x i8> %5 to <8 x i32>
  %7 = mul nsw <8 x i32> %6, %4
  %8 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %7)
  %9 = sitofp i32 %8 to float
  ret float %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local float @dot_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = shufflevector <8 x i16> %0, <8 x i16> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = sext <4 x i16> %3 to <4 x i32>
  %5 = shufflevector <8 x i16> %1, <8 x i16> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %6 = sext <4 x i16> %5 to <4 x i32>
  %7 = mul nsw <4 x i32> %6, %4
  %8 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %7)
  %9 = sitofp i32 %8 to float
  ret float %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local double @dot_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = extractelement <4 x i32> %0, i64 0
  %4 = extractelement <4 x i32> %1, i64 0
  %5 = mul nsw i32 %4, %3
  %6 = extractelement <4 x i32> %0, i64 1
  %7 = extractelement <4 x i32> %1, i64 1
  %8 = mul nsw i32 %7, %6
  %9 = add nsw i32 %5, %8
  %10 = sitofp i32 %9 to double
  ret double %10
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local double @dot_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = extractelement <2 x i64> %0, i64 0
  %4 = extractelement <2 x i64> %1, i64 0
  %5 = mul nsw i64 %4, %3
  %6 = sitofp i64 %5 to double
  ret double %6
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local float @dot_u18x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %4 = zext <8 x i8> %3 to <8 x i32>
  %5 = shufflevector <16 x i8> %1, <16 x i8> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %6 = zext <8 x i8> %5 to <8 x i32>
  %7 = mul nuw nsw <8 x i32> %6, %4
  %8 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %7)
  %9 = uitofp nneg i32 %8 to float
  ret float %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local float @dot_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = shufflevector <8 x i16> %0, <8 x i16> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %4 = zext <4 x i16> %3 to <4 x i32>
  %5 = shufflevector <8 x i16> %1, <8 x i16> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %6 = zext <4 x i16> %5 to <4 x i32>
  %7 = mul nuw nsw <4 x i32> %6, %4
  %8 = tail call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %7)
  %9 = uitofp nneg i32 %8 to float
  ret float %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @dot_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = extractelement <4 x i32> %0, i64 0
  %4 = extractelement <4 x i32> %1, i64 0
  %5 = mul i32 %4, %3
  %6 = extractelement <4 x i32> %0, i64 1
  %7 = extractelement <4 x i32> %1, i64 1
  %8 = mul i32 %7, %6
  %9 = add i32 %5, %8
  %10 = uitofp i32 %9 to double
  ret double %10
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @dot_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = extractelement <2 x i64> %0, i64 0
  %4 = extractelement <2 x i64> %1, i64 0
  %5 = mul i64 %4, %3
  %6 = uitofp i64 %5 to double
  ret double %6
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32>) #1

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
