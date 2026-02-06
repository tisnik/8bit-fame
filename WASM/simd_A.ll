; ModuleID = 'simd_A.c'
source_filename = "simd_A.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-i128:128-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @neg_i8x16(<16 x i8> noundef %0) local_unnamed_addr #0 {
  %2 = sub <16 x i8> zeroinitializer, %0
  ret <16 x i8> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @add_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = add <16 x i8> %1, %0
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @sub_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = sub <16 x i8> %0, %1
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @mul_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = mul <16 x i8> %1, %0
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @div_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = sdiv <16 x i8> %0, %1
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @neg_u8x16(<16 x i8> noundef %0) local_unnamed_addr #0 {
  %2 = sub <16 x i8> zeroinitializer, %0
  ret <16 x i8> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @add_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = add <16 x i8> %1, %0
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @sub_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = sub <16 x i8> %0, %1
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @mul_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = mul <16 x i8> %1, %0
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @div_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = udiv <16 x i8> %0, %1
  ret <16 x i8> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @neg_i16x8(<8 x i16> noundef %0) local_unnamed_addr #0 {
  %2 = sub <8 x i16> zeroinitializer, %0
  ret <8 x i16> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @add_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = add <8 x i16> %1, %0
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @sub_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = sub <8 x i16> %0, %1
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @mul_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = mul <8 x i16> %1, %0
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @div_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = sdiv <8 x i16> %0, %1
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @neg_u16x8(<8 x i16> noundef %0) local_unnamed_addr #0 {
  %2 = sub <8 x i16> zeroinitializer, %0
  ret <8 x i16> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @add_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = add <8 x i16> %1, %0
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @sub_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = sub <8 x i16> %0, %1
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @mul_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = mul <8 x i16> %1, %0
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <8 x i16> @div_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = udiv <8 x i16> %0, %1
  ret <8 x i16> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @neg_i32x4(<4 x i32> noundef %0) local_unnamed_addr #0 {
  %2 = sub <4 x i32> zeroinitializer, %0
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @add_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = add <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @sub_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = sub <4 x i32> %0, %1
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @mul_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = mul <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @div_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = sdiv <4 x i32> %0, %1
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @neg_u32x4(<4 x i32> noundef %0) local_unnamed_addr #0 {
  %2 = sub <4 x i32> zeroinitializer, %0
  ret <4 x i32> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @add_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = add <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @sub_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = sub <4 x i32> %0, %1
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @mul_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = mul <4 x i32> %1, %0
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x i32> @div_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = udiv <4 x i32> %0, %1
  ret <4 x i32> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @neg_i64x2(<2 x i64> noundef %0) local_unnamed_addr #0 {
  %2 = sub <2 x i64> zeroinitializer, %0
  ret <2 x i64> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @add_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = add <2 x i64> %1, %0
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @sub_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = sub <2 x i64> %0, %1
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @mul_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = mul <2 x i64> %1, %0
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @div_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = sdiv <2 x i64> %0, %1
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @neg_u64x2(<2 x i64> noundef %0) local_unnamed_addr #0 {
  %2 = sub <2 x i64> zeroinitializer, %0
  ret <2 x i64> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @add_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = add <2 x i64> %1, %0
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @sub_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = sub <2 x i64> %0, %1
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @mul_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = mul <2 x i64> %1, %0
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x i64> @div_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = udiv <2 x i64> %0, %1
  ret <2 x i64> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @neg_f32x4(<4 x float> noundef %0) local_unnamed_addr #0 {
  %2 = fneg <4 x float> %0
  ret <4 x float> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @add_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fadd <4 x float> %0, %1
  ret <4 x float> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @sub_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fsub <4 x float> %0, %1
  ret <4 x float> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @mul_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fmul <4 x float> %0, %1
  ret <4 x float> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @div_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fdiv <4 x float> %0, %1
  ret <4 x float> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @neg_f64x2(<2 x double> noundef %0) local_unnamed_addr #0 {
  %2 = fneg <2 x double> %0
  ret <2 x double> %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @add_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fadd <2 x double> %0, %1
  ret <2 x double> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @sub_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fsub <2 x double> %0, %1
  ret <2 x double> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @mul_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fmul <2 x double> %0, %1
  ret <2 x double> %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @div_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fdiv <2 x double> %0, %1
  ret <2 x double> %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+bulk-memory,+bulk-memory-opt,+call-indirect-overlong,+multivalue,+mutable-globals,+nontrapping-fptoint,+reference-types,+sign-ext,+simd128" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
