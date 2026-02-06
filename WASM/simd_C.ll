; ModuleID = 'simd_C.c'
source_filename = "simd_C.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-i128:128-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @mul_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = mul <16 x i8> %1, %0
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @mul_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = mul <16 x i8> %1, %0
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @mul_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = mul <8 x i16> %1, %0
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @mul_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = mul <8 x i16> %1, %0
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @mul_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = mul <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @mul_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = mul <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @mul_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = mul <2 x i64> %1, %0
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @mul_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = mul <2 x i64> %1, %0
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @mul_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fmul <4 x float> %0, %1
  ret <4 x float> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @mul_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fmul <2 x double> %0, %1
  ret <2 x double> %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+bulk-memory,+bulk-memory-opt,+call-indirect-overlong,+multivalue,+mutable-globals,+nontrapping-fptoint,+reference-types,+sign-ext,+simd128" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
