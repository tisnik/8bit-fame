; ModuleID = 'loop_6.c'
source_filename = "loop_6.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nofree norecurse nosync nounwind optsize memory(none)
define hidden i32 @loop(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt i32 %0, %1
  br i1 %3, label %4, label %8

4:                                                ; preds = %2, %4
  %5 = phi i32 [ %6, %4 ], [ %0, %2 ]
  %6 = mul nsw i32 %5, 3
  %7 = icmp slt i32 %6, %1
  br i1 %7, label %4, label %8, !llvm.loop !2

8:                                                ; preds = %4, %2
  %9 = phi i32 [ %0, %2 ], [ %6, %4 ]
  ret i32 %9
}

attributes #0 = { nofree norecurse nosync nounwind optsize memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
