; ModuleID = 'array_sum_3.c'
source_filename = "array_sum_3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@array = dso_local local_unnamed_addr global [100000 x float] zeroinitializer, align 16
@.str = private unnamed_addr constant [11 x i8] c"Sum: %.4f\0A\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"Time: %.4f ms\0A\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(read, argmem: none, inaccessiblemem: none) uwtable
define dso_local float @sum_array() local_unnamed_addr #0 {
  br label %2

1:                                                ; preds = %2
  ret float %35

2:                                                ; preds = %2, %0
  %3 = phi i64 [ 0, %0 ], [ %36, %2 ]
  %4 = phi float [ 0.000000e+00, %0 ], [ %35, %2 ]
  %5 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %3
  %6 = load float, ptr %5, align 16, !tbaa !3
  %7 = fadd float %4, %6
  %8 = or disjoint i64 %3, 1
  %9 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %8
  %10 = load float, ptr %9, align 4, !tbaa !3
  %11 = fadd float %7, %10
  %12 = or disjoint i64 %3, 2
  %13 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %12
  %14 = load float, ptr %13, align 8, !tbaa !3
  %15 = fadd float %11, %14
  %16 = or disjoint i64 %3, 3
  %17 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %16
  %18 = load float, ptr %17, align 4, !tbaa !3
  %19 = fadd float %15, %18
  %20 = or disjoint i64 %3, 4
  %21 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %20
  %22 = load float, ptr %21, align 16, !tbaa !3
  %23 = fadd float %19, %22
  %24 = or disjoint i64 %3, 5
  %25 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %24
  %26 = load float, ptr %25, align 4, !tbaa !3
  %27 = fadd float %23, %26
  %28 = or disjoint i64 %3, 6
  %29 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %28
  %30 = load float, ptr %29, align 8, !tbaa !3
  %31 = fadd float %27, %30
  %32 = or disjoint i64 %3, 7
  %33 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %32
  %34 = load float, ptr %33, align 4, !tbaa !3
  %35 = fadd float %31, %34
  %36 = add nuw nsw i64 %3, 8
  %37 = icmp eq i64 %36, 100000
  br i1 %37, label %1, label %2, !llvm.loop !7
}

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #1 {
  br label %1

1:                                                ; preds = %1, %0
  %2 = phi i64 [ 0, %0 ], [ %17, %1 ]
  %3 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %0 ], [ %18, %1 ]
  %4 = add <4 x i32> %3, splat (i32 4)
  %5 = and <4 x i32> %3, splat (i32 1)
  %6 = and <4 x i32> %3, splat (i32 1)
  %7 = icmp eq <4 x i32> %5, zeroinitializer
  %8 = icmp eq <4 x i32> %6, zeroinitializer
  %9 = sub nsw <4 x i32> zeroinitializer, %3
  %10 = sub <4 x i32> splat (i32 -4), %3
  %11 = select <4 x i1> %7, <4 x i32> %9, <4 x i32> %3
  %12 = select <4 x i1> %8, <4 x i32> %10, <4 x i32> %4
  %13 = sitofp <4 x i32> %11 to <4 x float>
  %14 = sitofp <4 x i32> %12 to <4 x float>
  %15 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %2
  %16 = getelementptr inbounds nuw i8, ptr %15, i64 16
  store <4 x float> %13, ptr %15, align 16, !tbaa !3
  store <4 x float> %14, ptr %16, align 16, !tbaa !3
  %17 = add nuw i64 %2, 8
  %18 = add <4 x i32> %3, splat (i32 8)
  %19 = icmp eq i64 %17, 100000
  br i1 %19, label %20, label %1, !llvm.loop !9

20:                                               ; preds = %1
  %21 = tail call i64 @clock() #4
  br label %22

22:                                               ; preds = %22, %20
  %23 = phi i64 [ 0, %20 ], [ %56, %22 ]
  %24 = phi float [ 0.000000e+00, %20 ], [ %55, %22 ]
  %25 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %23
  %26 = load float, ptr %25, align 16, !tbaa !3
  %27 = fadd float %24, %26
  %28 = or disjoint i64 %23, 1
  %29 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %28
  %30 = load float, ptr %29, align 4, !tbaa !3
  %31 = fadd float %27, %30
  %32 = or disjoint i64 %23, 2
  %33 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %32
  %34 = load float, ptr %33, align 8, !tbaa !3
  %35 = fadd float %31, %34
  %36 = or disjoint i64 %23, 3
  %37 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %36
  %38 = load float, ptr %37, align 4, !tbaa !3
  %39 = fadd float %35, %38
  %40 = or disjoint i64 %23, 4
  %41 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %40
  %42 = load float, ptr %41, align 16, !tbaa !3
  %43 = fadd float %39, %42
  %44 = or disjoint i64 %23, 5
  %45 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %44
  %46 = load float, ptr %45, align 4, !tbaa !3
  %47 = fadd float %43, %46
  %48 = or disjoint i64 %23, 6
  %49 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %48
  %50 = load float, ptr %49, align 8, !tbaa !3
  %51 = fadd float %47, %50
  %52 = or disjoint i64 %23, 7
  %53 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %52
  %54 = load float, ptr %53, align 4, !tbaa !3
  %55 = fadd float %51, %54
  %56 = add nuw nsw i64 %23, 8
  %57 = icmp eq i64 %56, 100000
  br i1 %57, label %58, label %22, !llvm.loop !7

58:                                               ; preds = %22
  %59 = tail call i64 @clock() #4
  %60 = fpext float %55 to double
  %61 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %60)
  %62 = sub nsw i64 %59, %21
  %63 = sitofp i64 %62 to double
  %64 = fdiv double %63, 1.000000e+06
  %65 = fmul double %64, 1.000000e+03
  %66 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef %65)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i64 @clock() local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

attributes #0 = { nofree norecurse nosync nounwind memory(read, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"float", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = distinct !{!9, !8, !10, !11}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
