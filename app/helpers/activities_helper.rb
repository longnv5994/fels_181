module ActivitiesHelper
  def create_activity action_type, target_id
    self.activities.build(user_id: self.id, target_id: target_id,
      action_type: action_type).save
  end
end
