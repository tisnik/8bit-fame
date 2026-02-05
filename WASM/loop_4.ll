; ModuleID = 'loop_4.c'
source_filename = "loop_4.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nounwind optsize
define hidden void @nested_loops() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %0, %8
  %2 = phi i32 [ 1, %0 ], [ %9, %8 ]
  br label %3

3:                                                ; preds = %1, %3
  %4 = phi i32 [ 1, %1 ], [ %6, %3 ]
  %5 = mul nuw nsw i32 %4, %2
  tail call void @print(i32 noundef %5) #2
  %6 = add nuw nsw i32 %4, 1
  %7 = icmp eq i32 %6, 11
  br i1 %7, label %8, label %3, !llvm.loop !2

8:                                                ; preds = %3
  %9 = add nuw nsw i32 %2, 1
  %10 = icmp eq i32 %9, 11
  br i1 %10, label %11, label %1, !llvm.loop !4

11:                                               ; preds = %8
  ret void
}

; Function Attrs: optsize
declare void @print(i32 noundef) local_unnamed_addr #1

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
