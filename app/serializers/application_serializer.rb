class ApplicationSerializer < ActiveModel::Serializer
  attributes :id

  protected
  def serialize_array(array, serializer, scope = nil)
    Api::V1::BaseController.serialize_array array, serializer, scope
  end
  def serialize_record(resource, serializer, scope = nil)
    Api::V1::BaseController.serialize_record resource, serializer, scope
  end
end
