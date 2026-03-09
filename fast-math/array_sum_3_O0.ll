; ModuleID = 'array_sum_3.c'
source_filename = "array_sum_3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@array = dso_local global [100000 x float] zeroinitializer, align 16
@.str = private unnamed_addr constant [11 x i8] c"Sum: %.4f\0A\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"Time: %.4f ms\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local float @sum_array() #0 {
  %1 = alloca float, align 4
  %2 = alloca i32, align 4
  store float 0.000000e+00, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %3

3:                                                ; preds = %13, %0
  %4 = load i32, ptr %2, align 4
  %5 = icmp slt i32 %4, 100000
  br i1 %5, label %6, label %16

6:                                                ; preds = %3
  %7 = load i32, ptr %2, align 4
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [100000 x float], ptr @array, i64 0, i64 %8
  %10 = load float, ptr %9, align 4
  %11 = load float, ptr %1, align 4
  %12 = fadd float %11, %10
  store float %12, ptr %1, align 4
  br label %13

13:                                               ; preds = %6
  %14 = load i32, ptr %2, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %2, align 4
  br label %3, !llvm.loop !4

16:                                               ; preds = %3
  %17 = load float, ptr %1, align 4
  ret float %17
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca float, align 4
  %5 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  br label %6

6:                                                ; preds = %24, %0
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %7, 100000
  br i1 %8, label %9, label %27

9:                                                ; preds = %6
  %10 = load i32, ptr %2, align 4
  %11 = srem i32 %10, 2
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %9
  %14 = load i32, ptr %2, align 4
  br label %18

15:                                               ; preds = %9
  %16 = load i32, ptr %2, align 4
  %17 = sub nsw i32 0, %16
  br label %18

18:                                               ; preds = %15, %13
  %19 = phi i32 [ %14, %13 ], [ %17, %15 ]
  %20 = sitofp i32 %19 to float
  %21 = load i32, ptr %2, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [100000 x float], ptr @array, i64 0, i64 %22
  store float %20, ptr %23, align 4
  br label %24

24:                                               ; preds = %18
  %25 = load i32, ptr %2, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %2, align 4
  br label %6, !llvm.loop !6

27:                                               ; preds = %6
  %28 = call i64 @clock() #3
  store i64 %28, ptr %3, align 8
  %29 = call float @sum_array()
  store float %29, ptr %4, align 4
  %30 = call i64 @clock() #3
  store i64 %30, ptr %5, align 8
  %31 = load float, ptr %4, align 4
  %32 = fpext float %31 to double
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %32)
  %34 = load i64, ptr %5, align 8
  %35 = load i64, ptr %3, align 8
  %36 = sub nsw i64 %34, %35
  %37 = sitofp i64 %36 to double
  %38 = fdiv double %37, 1.000000e+06
  %39 = fmul double %38, 1.000000e+03
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %39)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i64 @clock() #1

declare dso_local i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.mustprogress"}
!6 = distinct !{!6, !5}
