; ModuleID = 'numeric_types.c'
source_filename = "numeric_types.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef signext i8 @add_int8_t(i8 noundef signext %0, i8 noundef signext %1) local_unnamed_addr #0 {
  %3 = add i8 %1, %0
  ret i8 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef signext i16 @add_int16_t(i16 noundef signext %0, i16 noundef signext %1) local_unnamed_addr #0 {
  %3 = add i16 %1, %0
  ret i16 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local i32 @add_int32_t(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = add nsw i32 %1, %0
  ret i32 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local i64 @add_int64_t(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = add nsw i64 %1, %0
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef zeroext i8 @add_uint8_t(i8 noundef zeroext %0, i8 noundef zeroext %1) local_unnamed_addr #0 {
  %3 = add i8 %1, %0
  ret i8 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef zeroext i16 @add_uint16_t(i16 noundef zeroext %0, i16 noundef zeroext %1) local_unnamed_addr #0 {
  %3 = add i16 %1, %0
  ret i16 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef i32 @add_uint32_t(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = add i32 %1, %0
  ret i32 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef i64 @add_uint64_t(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = add i64 %1, %0
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @add_float(float noundef %0, float noundef %1) local_unnamed_addr #0 {
  %3 = fadd float %0, %1
  ret float %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @add_double(double noundef %0, double noundef %1) local_unnamed_addr #0 {
  %3 = fadd double %0, %1
  ret double %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
