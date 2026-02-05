; ModuleID = 'loop_2.c'
source_filename = "loop_2.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nounwind optsize
define hidden void @loop() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %0, %1
  %2 = phi i32 [ 0, %0 ], [ %4, %1 ]
  %3 = tail call i32 @foo(i32 noundef %2) #2
  %4 = add nuw nsw i32 %2, 1
  %5 = icmp eq i32 %4, 10
  br i1 %5, label %6, label %1, !llvm.loop !2

6:                                                ; preds = %1
  ret void
}

; Function Attrs: optsize
declare i32 @foo(i32 noundef) local_unnamed_addr #1

attributes #0 = { nounwind optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #1 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
