window.PlayList = React.createClass({
    getInitialState: function() {
        return {
          src: "https://embed.spotify.com/?uri=spotify:trackset:" + this.props.title + ":" + this.props.spotifyUris.join(',')
        };
    },

    handleUserInput: function(filterText, inStockOnly) {
        this.setState({
            filterText: filterText,
            inStockOnly: inStockOnly
        });
    },

    render: function() {
        return (
            <div>
              <iframe allowTransparency="true" 
                frameBorder="0" 
                height="500" 
                width="500"
                id="spotify_playlist" 
                src={this.state.src} >
              </iframe>
            </div>
        );
    }
});

//SPOTIFY_URIS = ['7wqSzGeodspE3V6RBD5W8L', '3eHopQk0VWyMbX13UdcRdO', '34gCuhDGsG4bRPIf9bb02f', '7J4gq1xNP3IsG6lDk0eSa7', '0udoMICxzaUbNUT8EVRq8B', '3D4QFgYa3P9P0gjmv4eX6I', '2mbfImsWprYXJrDst40SPz', '2azpRNbgwmjSmmQZ5PGJGT', '1q676iYDR3GeJtOHdyggIU', '3HXqalQmiJuoIpMa8aEhzc', '0OjzFUD0PFruiDcG4MWokj', '3XSczvk4MRteOw4Yx3lqMU', '0HFx7PLqzGxSfN59j3UHmR', '6YhDHby2eVeENKJNa7C2z6', '0rR9tCeZYiU8ipAMLxW6ha', '4kbj5MwxO1bq9wjT5g9HaA', '4j9gcCuM3RO2X7tR79YeFo', '1zsYMMoLICPfL4dPbbWsKL', '4KcVVhAaHxqtX2ANt4b3tc', '2ro2m7EQyssbcql18t4qkD', '6bSs2hFbUZHZmkaj0WSSfp', '6g4rKG32NC38vqsm4lf3fF', '4rmPQGwcLQjCoFq5NrTA0D', '357p2KRTBXeGGw6YfUI1nH', '4EGT5PAAPH05VqwR7IIBxW', '0N3W5peJUQtI4eyR6GJT5O', '1qx8bj4quT6XuP5P9Eu12Z', '02M6vucOvmRfMxTXDUwRXu', '6B76RwpMPJsHnhJexTHHcb', '0GwLe0LpHYcYf8Ca3KE7lX', '1N1JEeVv5TO2wQpk7vGVLs', '0A2FLtUzkCk7ct6KcqTx2l', '1xnwv757A6yItWjBoJxgPU', '79cbRQRVIDWp2MWl2ZLLkV', '0KyhqkY1VeKnCD8y22z6gp']

//React.render(<PlayList title="Playlist" spotifyUris={SPOTIFY_URIS} />, document.body);
