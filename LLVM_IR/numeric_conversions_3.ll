; ModuleID = 'numeric_conversions_3.c'
source_filename = "numeric_conversions_3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @convert_float_to_float(float noundef returned %0) local_unnamed_addr #0 {
  ret float %0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @convert_float_to_double(float noundef %0) local_unnamed_addr #0 {
  %2 = fpext float %0 to double
  ret double %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @convert_double_to_float(double noundef %0) local_unnamed_addr #0 {
  %2 = fptrunc double %0 to float
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @convert_double_to_double(double noundef returned %0) local_unnamed_addr #0 {
  ret double %0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @convert_int32_t_to_float(i32 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i32 %0 to float
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @convert_int32_t_to_double(i32 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i32 %0 to double
  ret double %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @convert_int64_t_to_float(i64 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i64 %0 to float
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @convert_int64_t_to_double(i64 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i64 %0 to double
  ret double %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local i32 @convert_float_to_int32_t(float noundef %0) local_unnamed_addr #0 {
  %2 = fptosi float %0 to i32
  ret i32 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local i32 @convert_double_to_int32_t(double noundef %0) local_unnamed_addr #0 {
  %2 = fptosi double %0 to i32
  ret i32 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local i64 @convert_float_to_int64_t(float noundef %0) local_unnamed_addr #0 {
  %2 = fptosi float %0 to i64
  ret i64 %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local i64 @convert_double_to_int64_t(double noundef %0) local_unnamed_addr #0 {
  %2 = fptosi double %0 to i64
  ret i64 %2
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
