; ModuleID = 'stack.c'
source_filename = "stack.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i32 @return_constant() local_unnamed_addr #0 {
  ret i32 42
}

; Function Attrs: nounwind optsize
define hidden i32 @call_x(i32 noundef %0) local_unnamed_addr #1 {
  %2 = tail call i32 @x(i32 noundef %0) #3
  ret i32 %2
}

; Function Attrs: optsize
declare i32 @x(i32 noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i32 @first(i32 noundef returned %0, i32 noundef %1) local_unnamed_addr #0 {
  ret i32 %0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i32 @second(i32 noundef %0, i32 noundef returned %1) local_unnamed_addr #0 {
  ret i32 %1
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i32 @try_return(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 0
  %3 = select i1 %2, i32 42, i32 9999
  ret i32 %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #1 = { nounwind optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #2 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #3 = { nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
