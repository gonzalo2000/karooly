class LessonsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @lessons = Lesson.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def references
    @lesson = Lesson.find(params[:id])
  end

  def enrollment_list
    @lesson = Lesson.find(params[:id])
  end

  helper_method :activities_completed?
  def activities_completed?(user)
    lesson ||= Lesson.find(params[:id])
    if current_enrollment = lesson.enrollment_for(user)
      current_enrollment.completed
    end
  end

  helper_method :completed_expo
  def completed_expo
    lesson = Lesson.find(params[:id])
    if current_enrollment = lesson.enrollment_for(current_user)
      all_expositions = current_enrollment.word_expositions
      all_expositions.all? { |word_expo| word_expo.completed == true }
    end
  end

  helper_method :completed_unscramble
  def completed_unscramble
    lesson = Lesson.find(params[:id])
    if current_enrollment = lesson.enrollment_for(current_user)
      all_unscramble = current_enrollment.scrambled_words
      all_unscramble.all? { |scrambled| scrambled.completed == true }
    end
  end

  helper_method :completed_dictations
  def completed_dictations
    lesson = Lesson.find(params[:id])
    if current_enrollment = lesson.enrollment_for(current_user)
      all_dictations = current_enrollment.word_dictations
      all_dictations.all? { |dictation| dictation.completed == true }
    end
  end

  helper_method :completed_spellings
  def completed_spellings
    lesson = Lesson.find(params[:id])
    if current_enrollment = lesson.enrollment_for(current_user)
      all_spellings = current_enrollment.image_spellings
      all_spellings.all? { |spelling| spelling.completed == true }
    end
  end

  helper_method :enrolled_users
  def enrolled_users
    lesson = Lesson.find(params[:id])
    enrollments = lesson.enrollments
    enrolled_users = enrollments.map { |enrollment| enrollment.user }
  end

  #for all users
  helper_method :completed_scram
  def completed_scram
    lesson = Lesson.find(params[:id])
    completed_scram = enrolled_users.map do |user|
      current_enrollment = lesson.enrollment_for(user)
      all_unscramble = current_enrollment.scrambled_words
      user if all_unscramble.all? { |scrambled| scrambled.completed == true }
    end
  end

  #for all users
  helper_method :completed_expos
  def completed_expos
    lesson = Lesson.find(params[:id])
    completed_expos = enrolled_users.map do |user|
      current_enrollment = lesson.enrollment_for(user)
      all_expos = current_enrollment.word_expositions
      user if all_expos.all? { |expos| expos.completed == true }
    end
  end

  #for all users
  helper_method :completed_dicts
  def completed_dicts
    lesson = Lesson.find(params[:id])
    completed_dic = enrolled_users.map do |user|
      current_enrollment = lesson.enrollment_for(user)
      all_dicts = current_enrollment.word_dictations
      user if all_dicts.all? { |dict| dict.completed == true }
    end
  end

  #for all users
  helper_method :completed_spel
  def completed_spel
    lesson = Lesson.find(params[:id])
    completed_sp = enrolled_users.map do |user|
      current_enrollment = lesson.enrollment_for(user)
      all_sp = current_enrollment.image_spellings
      user if all_sp.all? { |spell| spell.completed == true }
    end
  end
end
