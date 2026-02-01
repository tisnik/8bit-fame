; ModuleID = 'branching_2.c'
source_filename = "branching_2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind optsize memory(none) uwtable
define dso_local i32 @gcd(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %9, label %4

4:                                                ; preds = %2, %4
  %5 = phi i32 [ %6, %4 ], [ %0, %2 ]
  %6 = phi i32 [ %7, %4 ], [ %1, %2 ]
  %7 = urem i32 %5, %6
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %4, !llvm.loop !3

9:                                                ; preds = %4, %2
  %10 = phi i32 [ %0, %2 ], [ %6, %4 ]
  ret i32 %10
}

attributes #0 = { nofree norecurse nosync nounwind optsize memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.mustprogress"}
