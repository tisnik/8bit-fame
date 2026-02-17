; ModuleID = 'stack.c'
source_filename = "stack.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: nofree nosync nounwind optsize memory(none) uwtable
define dso_local i32 @ackermann(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, 0
  br i1 %3, label %4, label %7

4:                                                ; preds = %11, %2
  %5 = phi i32 [ %1, %2 ], [ %12, %11 ]
  %6 = add i32 %5, 1
  ret i32 %6

7:                                                ; preds = %2, %11
  %8 = phi i32 [ %12, %11 ], [ %1, %2 ]
  %9 = phi i32 [ %13, %11 ], [ %0, %2 ]
  %10 = icmp eq i32 %8, 0
  br i1 %10, label %11, label %15

11:                                               ; preds = %7, %15
  %12 = phi i32 [ %17, %15 ], [ 1, %7 ]
  %13 = add i32 %9, -1
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %4, label %7

15:                                               ; preds = %7
  %16 = add i32 %8, -1
  %17 = tail call i32 @ackermann(i32 noundef %9, i32 noundef %16) #1
  br label %11
}

attributes #0 = { nofree nosync nounwind optsize memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { optsize }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
