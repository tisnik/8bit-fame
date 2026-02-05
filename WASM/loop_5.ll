; ModuleID = 'loop_5.c'
source_filename = "loop_5.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nounwind optsize
define hidden void @nested_loops() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %0, %10
  %2 = phi i32 [ 1, %0 ], [ %11, %10 ]
  %3 = sitofp i32 %2 to double
  br label %4

4:                                                ; preds = %1, %4
  %5 = phi i32 [ 1, %1 ], [ %8, %4 ]
  %6 = sitofp i32 %5 to double
  %7 = fmul double %3, %6
  tail call void @print(double noundef %7) #2
  %8 = add nuw nsw i32 %5, 1
  %9 = icmp eq i32 %8, 11
  br i1 %9, label %10, label %4, !llvm.loop !2

10:                                               ; preds = %4
  %11 = add nuw nsw i32 %2, 1
  %12 = icmp eq i32 %11, 11
  br i1 %12, label %13, label %1, !llvm.loop !4

13:                                               ; preds = %10
  ret void
}

; Function Attrs: optsize
declare void @print(double noundef) local_unnamed_addr #1

attributes #0 = { nounwind optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #1 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
