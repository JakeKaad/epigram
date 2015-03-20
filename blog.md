<h1> Rails Stuff! </h1>

<p>So I wanted to go over 3 recurring problems I saw throughout the last couple days as these are problems that I struggled
with a lot in my first few weeks with Rails.  Hopefully the pain I felt then could alleviate some of the pain some of you
are feeling now </p>

<h3> Forms </h3>

<p> The first Major thing I want to point out is the difference between the rails form helpers.  Rails provides two
main form helpers: </P>

<h3> Forms </h3>
<h6> Model-backed form </h6>

<p>This is the first form we are exposed to in rails, it looks something like this: </p>

<code>
  <%= form_for @user do |f| %>
    <%= f.label :username %>
    <%= f.text_field :username %>
    ...etc
</code>

<p>This form has a LOT of magic.  It is awesome.  It knows whether you are creating a new object, it knows when you are updating,
it knows what controller and what controller method you need to go to.  This is great!  </p>

<p> One thing to remember, is that this form is only really for creating and updating models. Any other time you need
a form, you need another tool. The tag form.</p>

<h6> form_tag helper </h6>

<p> This is the rails helper for just creating simple forms.  You will use this a lot.  Login forms, upload forms
signup forms, registration forms, etc </p>  

<p> The documentation for these forms is actually pretty good.  The important thing to remember is, that you don't want 
to use anythin with a _tag in it on your model backed form, just like you don't want to use anything with an f._ in 
your _tag forms.  </p>

<h3> Model Backed Form collections </h3>

<p> This one is a struggle.  THe documentation on these SUCKS, BAD.  My first foray with check boxes cost me a
few days.  I'd like to run down the knowledge I gained struggling with these. (not these are for model-backed forms,
I am not quite sure how the form_tag collections work. </p>

<p> Our code: </p>

<code> 
  f.collection_check_boxes :user_id, @users, :id, :username do |cb|  
    cb.label(class: "checkbox inline") { cb.check_box(class: "checkbox") + cb.text } 
  end
</code>

<p> THe first line:  </p>
<ol>
  <li>:user_id = the parameter key that we are passing through, the value will be an array of user ids  </li>
  <li>@users = the collection of objects that we are using to create the checkboxes.  One per object </li>
  <li> :id = the meethod we are calling on the object create the values in the array we are passing in the paremters(:user_id in this case) <li>

  <li> :username = the method we are using to get the label text for each individual checkbox </li>
  
  <ol> In the CB block 
    <li> cb.label(class: "checkbox inline) = styling for the checkbox label </li>
    <li> { cb.check_box(class: "checkbox") + cb.text } = I'm honestly not quite sure.  I just know it needs this </li>
  </ol>
</ol>

<p> select boxes work pretty similarly.  I might be wrong on some of these, and if I am please tell me!  <p>

<h1> Has Many Through (tags)</h1>

<p> So, this is a big one.  Mike and I approached this in a slightly different fashion than most people, and I highly
recommend doing it like we did.  It is slightly difficult to follow at first, but ActiveRecord highly rewards you for 
doing it this way, and juming to polymorphic tables from this will be no problem (they are really awesome by the way.  
Lets see if I can break it down a little bit.  </p>

<p> First off, here is all of the relevant code from our Photo, User, and Tag models for this association </p>

<code>
  class User < ActiveRecord::Base
    has_many :photos
    has_many :tags
    has_many :tagged_photos, class_name: "Photo", foreign_key: "photo_id", through: :tags
  end
  
  class Tag < ActiveRecord::Base
    belongs_to :tagged_user, class_name: "User", foreign_key: :user_id
    belongs_to :tagged_photo, class_name: "Photo", foreign_key: :photo_id
    validates_uniqueness_of :user_id, scope: :photo_id
  end
  
  class Photo < ActiveRecord::Base
    belongs_to :user
    has_many :tags
    has_many :tagged_users, class_name: "User", foreign_key: "user_id", through: :tags
  end
</code>

<p> So what is going on here? This is a simple join table, but we are customizing the relationship names.  I know that it looks pretty
difficult to grok at first, but I promise its not that bad.  Lets start with the user class </p>


<p> First is our first <code> has_many :photos </code>.  This is because a photo is uploaded by a user and then belongs
to that user.  Simple enough.  This does lead us into a naming conflict that we will want to solve later</p>

<p> Second is your standard <code> has_many :tags </code>.  models have to own their join table in a :through relationship.<p>

<p> Finally, we have something intersting.  Lets look at <code> has_many :tagged_photos </code>  Here, we are customizing
the relationship name to avoid the conflict we will get by typing <code> @user.photos </code>.  When we customize a relationship name
we have to do some work that ActiveRecord normally does for us.  
  <ul>
    <li>We have to provide a class name <code> class_name: "User" </code> </li>
    <li>And tell ActiveRecord what foreign_key to look for in the join table <code> foreign_key: "user_id" </code>
  </ul>
</p>

<p> The photo model basically mirrors the user model in this regard.  So lets look at the Tag join table.  The join
table belongs to both models it is joining.  When you provide custom relationship names in the models, you have to use
them in the join table. That is why you see the same
  <code>belongs_to :tagged_photo, class_name: "Photo", foreign_key: :photo_id</code>
  Then we have :
  <code> validates_uniqueness_of :user_id, scope: :photo_id </code>
  This is providing scope to a uniqueness validation to make sure that we can only tag a user once per photo.
</p>

<h3>The End</h3>

<p> Thats all I have for the night.  I hope some of this was useful for some of you!  See you all tomorrow. </p>
