; ModuleID = 'comparison_operators.c'
source_filename = "comparison_operators.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @eq_int(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @ne_int(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @lt_int(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @le_int(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp sle i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @gt_int(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp sgt i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @ge_int(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp sge i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @eq_unsigned(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @ne_unsigned(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @lt_unsigned(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp ult i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @le_unsigned(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp ule i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @gt_unsigned(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp ugt i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local range(i32 0, 2) i32 @ge_unsigned(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp uge i32 %0, %1
  %4 = zext i1 %3 to i32
  ret i32 %4
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
