; ModuleID = 'simd_G.c'
source_filename = "simd_G.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-i128:128-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @eq_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @lt_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @le_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sle <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @gt_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sgt <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @ge_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sge <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @ne_i8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @eq_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @lt_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ult <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @le_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ule <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @gt_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ugt <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @ge_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp uge <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i8 -1, 1) <16 x i8> @ne_u8x16(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <16 x i8> %0, %1
  %4 = sext <16 x i1> %3 to <16 x i8>
  ret <16 x i8> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @eq_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @lt_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @le_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sle <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @gt_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sgt <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @ge_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sge <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @ne_i16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @eq_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @lt_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ult <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @le_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ule <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @gt_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ugt <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @ge_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp uge <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i16 -1, 1) <8 x i16> @ne_u16x8(<8 x i16> noundef %0, <8 x i16> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <8 x i16> %0, %1
  %4 = sext <8 x i1> %3 to <8 x i16>
  ret <8 x i16> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @eq_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @lt_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @le_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sle <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @gt_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sgt <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @ge_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sge <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @ne_i32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @eq_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @lt_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ult <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @le_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ule <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @gt_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ugt <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @ge_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp uge <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i32 -1, 1) <4 x i32> @ne_u32x4(<4 x i32> noundef %0, <4 x i32> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <4 x i32> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  ret <4 x i32> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @eq_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @lt_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @le_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sle <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @gt_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sgt <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @ge_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp sge <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @ne_i64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @eq_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @lt_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ult <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @le_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ule <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @gt_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ugt <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @ge_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp uge <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden range(i64 -1, 1) <2 x i64> @ne_u64x2(<2 x i64> noundef %0, <2 x i64> noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne <2 x i64> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  ret <2 x i64> %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @eq_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp oeq <4 x float> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  %5 = bitcast <4 x i32> %4 to <4 x float>
  ret <4 x float> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @lt_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp olt <4 x float> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  %5 = bitcast <4 x i32> %4 to <4 x float>
  ret <4 x float> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @le_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp ole <4 x float> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  %5 = bitcast <4 x i32> %4 to <4 x float>
  ret <4 x float> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @gt_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp ogt <4 x float> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  %5 = bitcast <4 x i32> %4 to <4 x float>
  ret <4 x float> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @ge_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp oge <4 x float> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  %5 = bitcast <4 x i32> %4 to <4 x float>
  ret <4 x float> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <4 x float> @ne_f32x4(<4 x float> noundef %0, <4 x float> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp une <4 x float> %0, %1
  %4 = sext <4 x i1> %3 to <4 x i32>
  %5 = bitcast <4 x i32> %4 to <4 x float>
  ret <4 x float> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @eq_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp oeq <2 x double> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  %5 = bitcast <2 x i64> %4 to <2 x double>
  ret <2 x double> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @lt_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp olt <2 x double> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  %5 = bitcast <2 x i64> %4 to <2 x double>
  ret <2 x double> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @le_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp ole <2 x double> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  %5 = bitcast <2 x i64> %4 to <2 x double>
  ret <2 x double> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @gt_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp ogt <2 x double> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  %5 = bitcast <2 x i64> %4 to <2 x double>
  ret <2 x double> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @ge_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp oge <2 x double> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  %5 = bitcast <2 x i64> %4 to <2 x double>
  ret <2 x double> %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <2 x double> @ne_f64x2(<2 x double> noundef %0, <2 x double> noundef %1) local_unnamed_addr #0 {
  %3 = fcmp une <2 x double> %0, %1
  %4 = sext <2 x i1> %3 to <2 x i64>
  %5 = bitcast <2 x i64> %4 to <2 x double>
  ret <2 x double> %5
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+bulk-memory,+bulk-memory-opt,+call-indirect-overlong,+multivalue,+mutable-globals,+nontrapping-fptoint,+reference-types,+sign-ext,+simd128" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
