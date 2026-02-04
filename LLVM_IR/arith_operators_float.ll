; ModuleID = 'arith_operators_float.c'
source_filename = "arith_operators_float.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @neg_float(float noundef %0) local_unnamed_addr #0 {
  %2 = fneg float %0
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @add_float(float noundef %0, float noundef %1) local_unnamed_addr #0 {
  %3 = fadd float %0, %1
  ret float %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @sub_float(float noundef %0, float noundef %1) local_unnamed_addr #0 {
  %3 = fsub float %0, %1
  ret float %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @mul_float(float noundef %0, float noundef %1) local_unnamed_addr #0 {
  %3 = fmul float %0, %1
  ret float %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef float @div_float(float noundef %0, float noundef %1) local_unnamed_addr #0 {
  %3 = fdiv float %0, %1
  ret float %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @neg_double(double noundef %0) local_unnamed_addr #0 {
  %2 = fneg double %0
  ret double %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @add_double(double noundef %0, double noundef %1) local_unnamed_addr #0 {
  %3 = fadd double %0, %1
  ret double %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @sub_double(double noundef %0, double noundef %1) local_unnamed_addr #0 {
  %3 = fsub double %0, %1
  ret double %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @mul_double(double noundef %0, double noundef %1) local_unnamed_addr #0 {
  %3 = fmul double %0, %1
  ret double %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef double @div_double(double noundef %0, double noundef %1) local_unnamed_addr #0 {
  %3 = fdiv double %0, %1
  ret double %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
