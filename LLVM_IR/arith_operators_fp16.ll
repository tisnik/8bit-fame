; ModuleID = 'arith_operators_fp16.c'
source_filename = "arith_operators_fp16.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef half @neg__Float16(half noundef %0) local_unnamed_addr #0 {
  %2 = fneg half %0
  ret half %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef half @add__Float16(half noundef %0, half noundef %1) local_unnamed_addr #0 {
  %3 = fadd half %0, %1
  ret half %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef half @sub__Float16(half noundef %0, half noundef %1) local_unnamed_addr #0 {
  %3 = fsub half %0, %1
  ret half %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef half @mul__Float16(half noundef %0, half noundef %1) local_unnamed_addr #0 {
  %3 = fmul half %0, %1
  ret half %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef half @div__Float16(half noundef %0, half noundef %1) local_unnamed_addr #0 {
  %3 = fdiv half %0, %1
  ret half %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
