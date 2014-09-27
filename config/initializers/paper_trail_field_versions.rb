# PaperTrail::Version.class_eval do
#   def self.field_version_values_for_class(model, fields = {}, max_objects)
#     model_versions = PaperTrail::Version.where(item_type: model.to_s)
#     model_versions_for_fields = []
#     if fields
#       if fields.respond_to?(:each)
#
#       else
#         field = fields.to_s
#         model_versions.each do |v|
#           c = v.changeset
#
#           if c.keys.include?(field)
#             model_versions_for_fields.push(v)
#           end
#         end
#       end
#     end
#
#     model_versions_for_fields
#   end
# end
#

class PaperTrail::Version
  def self.field_version_values_for_class(model, fields = {}, max_objects = 0)
    model_versions = PaperTrail::Version.where(item_type: model.to_s)
    model_versions_for_fields = []
    if fields
      if fields.respond_to?(:each)

      else
        field = fields.to_s
        model_versions.each do |v|
          c = v.changeset

          if c.keys.include?(field) && v.item
            model_versions_for_fields.push(v)
          end
        end
      end
    end

    model_versions_for_fields
  end
end