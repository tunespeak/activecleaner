# encoding: utf-8
require "spec_helper"

#
# The case
#
# This is to demonstrate when we want to clean some simple fields
#
class Post
  include ActiveCleaner

  attr_accessor :title, :name, :body

  clean :title
  clean :name, as: :string
  clean :body, as: :text
end


#
# The specs
#
describe "Case: a simple post" do

  describe Post, "._cleaners" do

    subject { Post._cleaners }

    it "has 3 cleaners" do
      expect(subject.length).to eq(3)
    end

    it "includes a StringCleaner for #title" do
      expect(subject[:title].first).to eq(ActiveCleaner::StringCleaner.new(:title))
    end

    it "includes a StringCleaner for #name" do
      expect(subject[:name].first).to eq(ActiveCleaner::StringCleaner.new(:name))
    end

    it "includes a TextCleaner for #body" do
      expect(subject[:body].first).to eq(ActiveCleaner::TextCleaner.new(:body))
    end

  end # describe

  context "considering a post" do

    let(:subject) { Post.new }

    describe "#title, marked as to clean with no type" do

      it "is untouched when legit" do
        subject.title = "A good title!"
        subject.valid?
        expect(subject.title).to eq("A good title!")
      end

      it "is cleaned as a string" do
        subject.title = "  A  \n good  \t title!  "
        subject.valid?
        expect(subject.title).to eq("A good title!")
      end

    end # describe

    describe "#name, marked as to clean as a string" do

      it "is untouched when legit" do
        subject.name = "John Doe"
        subject.valid?
        expect(subject.name).to eq("John Doe")
      end

      it "is cleaned as a string" do
        subject.name = "  \t  John  \n  Doe     "
        subject.valid?
        expect(subject.name).to eq("John Doe")
      end

    end # describe

    describe "#body, marked as to clean as a text" do

      it "is untouched when legit" do
        subject.body = "Lorem ipsum\ndolor sit amet.\n\nLorem."
        subject.valid?
        expect(subject.body).to eq("Lorem ipsum\ndolor sit amet.\n\nLorem.")
      end

      it "is cleaned as a text" do
        subject.body = "Lorem \t ipsum \t \n   dolor \t sit \t amet.\n\n\nLorem."
        subject.valid?
        expect(subject.body).to eq("Lorem ipsum\ndolor sit amet.\n\nLorem.")
      end

    end # describe

  end # context

end # describe
