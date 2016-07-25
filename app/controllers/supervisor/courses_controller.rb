class Supervisor::CoursesController < ApplicationController
  load_and_authorize_resource

  def index
    @courses = current_user.courses.page params[:page]
  end

  def show
    @users_in_course = @course.user_courses.includes :user
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "supervisor.update_success"
      if @course.finish?
        @course.course_subjects.each {|course_subject|
          course_subject.update_attributes(status: "finish")}
      end
      redirect_to supervisor_course_path @course
    else
      flash[:danger] = t "supervisor.update_fail"
      redirect_to supervisor_course_path
    end

  end

  private
  def course_params
    params.require(:course).permit :status
  end
end
