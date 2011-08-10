require 'spec_helper'

describe Milestone do

  it 'skill_list' do
    s1 = Factory(:step, :skill_list => ['one', 'two'])
    s2 = Factory(:step, :skill_list => ['two'])
    s3 = Factory(:step, :skill_list => ['two', 'three'])
    m = Factory(:milestone, :steps => [s3, s2, s1])
    m.skill_list.sort.should == ['one', 'two', 'three'].sort
  end
end
