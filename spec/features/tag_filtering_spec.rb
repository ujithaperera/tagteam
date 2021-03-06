require "rails_helper"

feature 'Tag filtering', wip: true do

  def add_filter(tag_name = 'add-test')
    new_tag = create(:tag, name: tag_name)
    create(:add_tag_filter, tag: new_tag, hub: @hub, scope: @hub)
  end

  include_context "user owns a hub with a feed and items"
  it "rolls back its changes when removed" do
    tag_lists = tag_lists_for(@feed_items, @hub.tagging_key, true)

    filter = add_filter
    filter.destroy

    new_tag_lists = tag_lists_for(@feed_items.reload, @hub.tagging_key, true)

    expect(new_tag_lists).to eq tag_lists
  end


  context "the filter exists" do
    before(:each) do
      @filter = add_filter
    end

    it "loses precedence to more recent filters" do
      pending('Not yet implemeneted')
      @hub.tag_filters << create(:add_tag_filter)

      expect(@hub.tag_filters.last).to_not eq @filter
    end

    it "cannot be duplicated in a hub", wip: true do
    end

    context "it's older than another filter" do
      it "regains precedence when renewed" do
        pending('Renew is not yet implemeneted')
        @hub.tag_filters << create(:tag_filter)
        @filter.renew
        expect(@hub.tag_filters.last).to eq @filter
      end
    end
  end

  context "A hub-level filter exists that adds a tag" do
    before(:each) do
    end

    it "takes precedence over the existing filter", wip: true do
    end
  end
end
