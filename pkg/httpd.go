package httpd

import (
	"fmt"
	"net/http"
)

func Serve(opts ServeOptions) error {
	fmt.Println("httpd: a tiny http server")
	http.Handle(opts.URI, http.StripPrefix(opts.URI, http.FileServer(http.Dir(opts.Dirpath))))
	fmt.Printf("httpd serve: %s\n", opts.Address)
	return http.ListenAndServe(opts.Address, nil)
}
