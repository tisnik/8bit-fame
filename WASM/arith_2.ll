; ModuleID = 'arith_2.c'
source_filename = "arith_2.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden i64 @iadd(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = add nsw i64 %1, %0
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden i64 @isub(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = sub nsw i64 %0, %1
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden i64 @imul(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = mul nsw i64 %1, %0
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i64 @idiv(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = sdiv i64 %0, %1
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i64 @imod(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = srem i64 %0, %1
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i64 @uadd(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = add i64 %1, %0
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i64 @usub(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = sub i64 %0, %1
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i64 @umul(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = mul i64 %1, %0
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i64 @udiv(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = udiv i64 %0, %1
  ret i64 %3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef i64 @umod(i64 noundef %0, i64 noundef %1) local_unnamed_addr #0 {
  %3 = urem i64 %0, %1
  ret i64 %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
