# "Augmentations" plugin for Rails.
# By Henrik Nyh <http://henrik.nyh.se> under the MIT license for DanceJam <http://dancejam.com> 2008-09-10.
# See README for usage.

class ::Object
  def self.better_include(*mods)
    include *mods
    mods.each {|mod| class_eval &mod.better_included }
  end
end

class ::Module
  def better_included(&block)
    @augmentation ||= block
  end
end