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
            browser = Watir::Browser.new :chrome, switches: ['--incognito']
            browser.goto("facebook.com")
            browser.text_field(name: "email").set('arma23430@gmail.com')
            browser.text_field(name: 'pass').set('arsenalsuper1900')    
            browser.button(type: "submit").click
            browser.goto('facebook.com')
            browser.text_field(name:"q").set(args.keyword)  
            browser.button(type: "submit",).click
            browser.div(class:'_4xjz',  index:1).click
            browser.span(class:"_5dw8", index:0).click
            sleep 1
            index=0
            body_index=0
            comments_index=0
            likes_index=0
            location_index=0
            comment_index=0
            like_index=0
            more_comments_index=0
            while index<=10
                browser.element(class:'_401d',index:index).click
                sleep 1             
                    if browser.element(class:'_62xw',index:location_index).exist?
                        location=browser.element(class:'_62xw',index:location_index).text
                        location_index=location_index+1
                    end 
                    if browser.element(class:'_1g5v',index:index).exist?
                        likes=browser.element(class:'_1g5v',index:likes_index).text
                        likes_index=likes_index+1 
                    end
                    if browser.element(class:'_-56', index:comments_index).exist?
                        comments=browser.element(class:'_-56', index:comments_index).text 
                        comments_index=comments_index+1
                    end
                    date=browser.element(class:'_5ptz',index:index).title if browser.element(class:'_5ptz',index:index).exist?
                    author=browser.element(class:'_lic',index:index).text if browser.element(class:'_lic',index:index).exist?
                    if browser.element(class:"_5pbx", index:body_index).exist?
                        body=browser.element(class:"_5pbx", index:body_index).text
                        body_index=body_index+1
                    end
                Post.create(comments: comments,Location: location,Creation_Date: date,body: body,author: author,likes: likes)
                date=nil 
                comments=nil 
                location=nil  
                body=nil 
                likes=nil 
                author=nil 
                location=nil 
                index=index+1
                    #if browser.element(class:'_-56', index:comments_index).exist?
                     #   browser.element(class:'_-56', index:comments_index).click
                      #  while browser.element(class:'UFIPagerLink', index:more_comments_index).exist?
                       #     browser.element(class:'UFIPagerLink', index:more_comments_index).click
                        #    more_comments_index=more_comments_index+1
                       # end  
                       # comments_index=comments_index+1
                    #end
                    #while comment_index<=comment_index+comments.to_i
                     #   date=browser.element(class:'UFISutroCommentTimestamp', index:comment_index).text if browser.element(class:'UFISutroCommentTimestamp', index:comment_index).exist?
                     #   author=browser.element(class:'UFICommentActorName', index:comment_index).text if browser.element(class:'UFICommentActorName', index:comment_index).exist?
                     #   body= browser.element(class:'UFICommentBody', index:comment_index).text if browser.element(class:'UFICommentBody', index:comment_index).exist?
                     #   if browser.element(class:'UFICommentLikeButton', index:like_index).exist?
                      #      likes=browser.element(class:'UFICommentLikeButton', index:like_index).text
                       #     like_index=like_index+1 
                       # end
                       # comment_index=comment_index+1
                       # Post.create(Creation_Date: date,body: body,author: author,likes: likes)
                      #  body=nil 
                      #  likes=nil 
                      #  author=nil
                      #  date=nil
                    #end
            end
                browser.close
                next
            #index=0
            # browser.elements(class:'_401d').each do |a|
            #     index=index+1
            #    if a.present? 
            #        a.click  
            #        sleep 2
            #        author=browser.element(class:'fwb',index:index).text
            #        body=browser.element(class:'_5px',index:index).text
            #        likes=browser.element(class:'_1g5v',index:index).text
            #        Post.create(body:body,author:author,likes:likes)
            #   end
        # end
    end 
    #browser.element(:css, "div[data-insertion-position='0']").click
    #browser.text
    #browser.driver.executeScript("window.scrollBy(0,200)")
end