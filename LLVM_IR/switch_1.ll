; ModuleID = 'switch_1.c'
source_filename = "switch_1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable
define dso_local noundef i32 @numeric_value(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  switch i32 %0, label %11 [
    i32 0, label %3
    i32 1, label %5
    i32 2, label %7
    i32 3, label %9
  ]

3:                                                ; preds = %2
  %4 = add i32 %1, 1
  br label %11

5:                                                ; preds = %2
  %6 = add i32 %1, 2
  br label %11

7:                                                ; preds = %2
  %8 = add i32 %1, -2
  br label %11

9:                                                ; preds = %2
  %10 = add i32 %1, -1
  br label %11

11:                                               ; preds = %2, %9, %7, %5, %3
  %12 = phi i32 [ %1, %2 ], [ %10, %9 ], [ %8, %7 ], [ %6, %5 ], [ %4, %3 ]
  ret i32 %12
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
