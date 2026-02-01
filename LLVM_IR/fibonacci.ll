; ModuleID = 'fibonacci.c'
source_filename = "fibonacci.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind optsize memory(none) uwtable
define dso_local i64 @fibonacciIter(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %3, label %5

3:                                                ; preds = %1
  %4 = sext i32 %0 to i64
  br label %12

5:                                                ; preds = %1, %5
  %6 = phi i64 [ %10, %5 ], [ 1, %1 ]
  %7 = phi i64 [ %6, %5 ], [ 0, %1 ]
  %8 = phi i32 [ %9, %5 ], [ %0, %1 ]
  %9 = add nsw i32 %8, -1
  %10 = add nsw i64 %6, %7
  %11 = icmp samesign ugt i32 %8, 2
  br i1 %11, label %5, label %12, !llvm.loop !3

12:                                               ; preds = %5, %3
  %13 = phi i64 [ %4, %3 ], [ %10, %5 ]
  ret i64 %13
}

attributes #0 = { nofree norecurse nosync nounwind optsize memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.mustprogress"}
