package httpd

type ServeOptions struct {
	Address string `yaml:"address"`
	URI     string `yaml:"uri"`
	Dirpath string `yaml:"path"`
}
