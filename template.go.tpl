import (
	"context"
	"fmt"

	"github.com/gogf/gf/v2/errors/gcode"
	"github.com/gogf/gf/v2/errors/gerror"
	"github.com/gogf/gf/v2/frame/g"
)

type s{{$.Name}} struct{}

func New() *s{{$.Name}} {
	return &s{{$.Name}}{}
}

func init() {
	service.Register{{$.Name}}(New())
}
{{range .Methods}}
{{if eq .Method "GET"}}
func (s *s{{$.Name}}) {{ .HandlerName }} (ctx context.Context, in *model.{{ .HandlerName }}Input) (out *model.{{ .HandlerName }}Output, err error) {
	var list []*entity.{{$.Name}}
	err = dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Ids).Scan(&list)
	if err != nil {
		return
	}

	return &model.{{ .HandlerName }}Output{
		{{$.Name}}List: list,
	}, nil
}
{{else if eq .Method "POST"}}
func (s *s{{$.Name}}) {{ .HandlerName }} (ctx context.Context, in *model.{{ .HandlerName }}Input) (err error) {
	{{$.Name}} := &do.{{$.Name}}{

	}
	err = dao.{{$.Name}}.Ctx(ctx).Data({{$.Name}}).Insert()
	if err != nil {
		return
	}

	return nil
}

{{else if eq .Method "PUT"}}
func (s *s{{$.Name}}) {{ .HandlerName }} (ctx context.Context, in *model.{{ .HandlerName }}Input) (err error) {
	{{$.Name}} := &do.{{$.Name}}{

	}
	err = dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Data({{$.Name}}).Update()
	if err != nil {
		return
	}

	return nil
}

{{else if eq .Method "DELETE"}}
func (s *s{{$.Name}}) {{ .HandlerName }} (ctx context.Context, in *model.{{ .HandlerName }}Input) (err error) {
    err = dao.{{$.Name}}.Ctx(ctx).Where(dao.{{$.Name}}.Columns().Id, in.Id).Delete()
    if err != nil {
        return
    }
    return nil
}
{{end}}

{{end}}