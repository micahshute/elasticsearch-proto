const express = require('express')

const mongoose = require('mongoose')
const mongoDB = "mongodb://localhost:27017/articles"

mongoose.connect(mongoDB, {
    useNewUrlParser: true,
    useUnifiedTopography: true
})

const db = mongoose.connection
db.on('error', console.error.bind(console, 'MongoDB connection error:'))

const app =  express()
const port = 3000


// START ROUTES

require('./models/Post')
const Post = mongoose.model('Post')

app.get('/', (req, res) => {
    res.send('Hello, World!')
})

app.get('/posts/sync', async (req, res) => {
    const Post = mongoose.model('Post')
    let count = 0
    let sent = false
    console.log(count)
    const stream = Post.synchronize((err) => {
        if(err){
            console.log(`Error on sync: ${err}`)
            return res.send(`Error:${err}`)
        }
        
    })
    stream.on('data', (err, doc) => {
        count++
    })
    stream.on('close', () => {
        if(!sent){
            sent = true
            console.log(`Successfully synced ${count} posts`)
            res.send(`Synced ${count} posts`)
        }
    })
    stream.on('error', (err) => {
        if(err) { 
            console.log(`Stream error: ${err}`)
            // return res.send(`Error: ${err}`) 
        }
    })


})


app.get('/posts/:id', (req, res) => {
    posts = Post.find({"_id": Number.parseInt(req.params.id)})
    posts.select('Tag Title Text')
    posts.exec((err, all_posts) => {
        if(err){ return res.send(err)}
        // console.log(all_posts[0])
        post = all_posts[0]
        res.send(`Tag: ${post.Tag}; TItle:${post.Title}\n\n\nBody:${post.Text}`)
    })
})




// END ROUTES

app.listen(port, () => {
    console.log(`Listening on port ${port}...`)
})