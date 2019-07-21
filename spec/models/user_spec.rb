require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "validations" do
    before do
      @user = User.new(name: "tanaka_waka", email: "abc@example.com", field: "田中テスト", 
                       password: "foobar", password_confirmation: "foobar")
      @other_user = User.new(name: "sasaki_taka", email: "reaction@voice.com", field: "検証太郎", 
                             password: "foobaz", password_confirmation: "foobaz")
    end
    
    describe "presence" do
      
      it "is not be valid without name" do
        @user.name = ""
        expect(@user).not_to be_valid
      end
  
      it "is not be valid without field" do
        @user.field = ""
        expect(@user).not_to be_valid
      end

      it "is not be valid without email" do
        @user.email = ""
        expect(@user).not_to be_valid
      end
  
    end
    
    describe "characters" do
      
      context "name is too long(over 50 characters)" do
        it "is invalid" do
          @user.name = "a" * 51
          expect(@user).not_to be_valid
        end
      end
      
      context "email is too long(over 255 characters)" do
        it "is invalid" do
          @user.email = "a" * 244 + "@example.com"
          expect(@user).not_to be_valid
        end
      end
      
      context "password is too short(under 6 characters)" do
        it "is invalid" do
          @user.password = @user.password_confirmation = "a" * 5
          expect(@user).not_to be_valid
        end
      end
      
    end  
    
    describe "email format" do
      
      context "when adress is invalid format" do
        it "is invalid" do
          invalid_formats = %w[abc@example,com abc.example.com abc@example_com]
          invalid_formats.each do |invalid_format|
            @user.email = invalid_format
            expect(@user).not_to be_valid
          end
        end
      end
      
      context "when adress is valid format" do
        it "is valid" do
          valid_formats = %w[abc@example.com ab-c.d@example.com d23456@example.com]
          valid_formats.each do |valid_format|
            @user.email = valid_format
            expect(@user).to be_valid
          end
        end
      end  
            
    end
    
    describe "uniqueness" do
      
      context "same email adress already exists" do
        it "is invalid" do
          @other_user.email = @user.email.upcase
          @user.save
          expect(@other_user).not_to be_valid
        end
      end
      
      context "same name already exists" do
        it "is invalid" do
          @other_user.name = @user.name
          @user.save
          expect(@other_user).not_to be_valid
        end
      end
      
    end
    
  end  
end
