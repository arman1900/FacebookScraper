namespace :parse do
    desc "Parse socialsites"
        task :facebook,[:keyword] => :environment do  |t, args|
            args.with_defaults(:keyword => 'Kazakhstan')
            require 'watir'
            require 'watir-scroll'
            opts = {
                switches: ['--incognito', '--headless']   
            }
            if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
                opts.merge!( options: {binary: chrome_bin})
            end 
            Post.destroy_all
            browser = Watir::Browser.new :chrome,  opts
            browser.goto("facebook.com")
            browser.text_field(name: "email").set('arma23430@gmail.com')
            browser.text_field(name: 'pass').set('arsenalsuper1900')    
            browser.button(type: "submit").click
            browser.goto('facebook.com')
            browser.text_field(name:"q").set(args.keyword)  
            browser.button(type: "submit",).click
            browser.div(class:'_4xjz',  index:1).click
            sleep 1
            index=0
            body_index=0
            comments_index=0
            likes_index=0
            location_index=0
            comment_index=0
            like_index=0
            more_comments_index=0
            replies=0
            while index<=2
                browser.element(class:'_o02',index:index).click
                sleep 1
                parent=browser.div(class:'_3ccb',index:0)
                sleep 1             
                    if browser.element(class:'_62xw',index:location_index).exist?
                        child=browser.div(class:'_62xw',index:location_index    )
                        element_browser = parent.elements.any? {|e| e=child} rescue false
                        if element_browser
                            location=child.text
                            location_index=location_index+1
                        end
                    end 
                    if browser.element(class:'_1g5v',index:likes_index).exist?
                        child=browser.span(class:'_1g5v',index:likes_index)
                        element_browser = parent.elements.any? {|e| e=child} rescue false
                        if element_browser
                            likes=child.text
                            likes_index=likes_index+1
                        end 
                    end
                    element_browser=false
                    if browser.element(class:'_-56', index:comments_index).exist?
                        child=browser.a(class:'_-56',index:comments_index)
                        element_browser = parent.elements.any? {|e| e=child} rescue false
                        if element_browser
                            comments=child.text
                        end 
                    end
                    date=browser.element(class:'_5ptz',index:0).title if browser.element(class:'_5ptz',index:0).exist?
                    author=browser.element(class:'_lic',index:index).text if browser.element(class:'_lic',index:index).exist?
                    if browser.element(class:"_5pbx").exist?
                        body=browser.element(class:"_5pbx").text
                    end
                Post.create(comments: comments,Location: location,Creation_Date: date,body: body,author: author,likes: likes)
                date=nil  
                location=nil  
                body=nil 
                likes=nil 
                author=nil 
                location=nil 
                index=index+1
                browser.refresh 
                    if element_browser
                        browser.element(class:'_-56', index:comments_index).click
                            while(more_comments_index<=40)
                                if browser.element(class:'UFIPagerLink', index:more_comments_index).exist?
                                    puts more_comments_index
                                    browser.element(class:'UFIPagerLink', index:more_comments_index).click
                                    sleep 1
                                else 
                                    more_comments_index=40
                                end
                                more_comments_index=more_comments_index+1
                            end
                            sleep 1
                            while(replies<=40)
                                if browser.element(class:'UFICommentLink',index:replies).exist?
                                    puts replies
                                    browser.element(class:'UFICommentLink',index:replies).click
                                    sleep 1
                                else
                                    replies=40
                                end
                                replies=replies+1
                            end
                        comments_index=comments_index+1
                    end
                    more_comments_index=0
                    replies=0
                    j=[comments.to_i,50].min
                    sleep 1
                    while comment_index<j
                        date=browser.element(class:'UFISutroCommentTimestamp', index:comment_index).text if browser.element(class:'UFISutroCommentTimestamp', index:comment_index).exist?
                        author=browser.element(class:'UFICommentActorName', index:comment_index).text if browser.element(class:'UFICommentActorName', index:comment_index).exist?
                        body= browser.element(class:'UFICommentBody', index:comment_index).text if browser.element(class:'UFICommentBody', index:comment_index).exist?
                        if browser.element(class:'UFICommentLikeButton', index:like_index).exist?
                            likes=browser.element(class:'UFICommentLikeButton', index:like_index).text
                            like_index=like_index+1 
                        end
                        comment_index=comment_index+1
                        Post.create(Creation_Date: date,body: body,author: author,likes: likes)
                        body=nil 
                        likes=nil 
                        author=nil
                        date=nil
                    end
                comments=nil
                comment_index=0
                browser.refresh 
            end
                browser.close
                next
        end
end