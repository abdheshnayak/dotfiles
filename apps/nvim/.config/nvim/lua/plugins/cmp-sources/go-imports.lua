local source = {}

local common_go_imports = {
  -- k8s.io types
  'corev1 "k8s.io/api/core/v1"',
  'appsv1 "k8s.io/api/apps/v1"',
  'metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"',
  'storagev1 "k8s.io/api/storage/v1"',
  'networkingv1 "k8s.io/api/networking/v1"',
  'autoscalingv2 "k8s.io/api/autoscaling/v2"',

  -- k8s.io utils
  'yamlutil "k8s.io/apimachinery/pkg/util/yaml"',

  -- apimachinery
  'apiErrors "k8s.io/apimachinery/pkg/api/errors"',
  'apiLabels "k8s.io/apimachinery/pkg/labels"',
  'apiTypes "k8s.io/apimachinery/pkg/types"',
  'apiMeta "k8s.io/apimachinery/pkg/api/meta"',

  -- sigs.k8s.io
  '"sigs.k8s.io/yaml"',
  'ctrl "sigs.k8s.io/controller-runtime"',
  'controllerutil "sigs.k8s.io/controller-runtime/pkg/controller/controllerutil"',
  '"sigs.k8s.io/controller-runtime/pkg/client"',
  '"sigs.k8s.io/controller-runtime/pkg/handler"',
  '"sigs.k8s.io/controller-runtime/pkg/source"',
  '"sigs.k8s.io/controller-runtime/pkg/reconcile"',
  '"sigs.k8s.io/controller-runtime/pkg/controller"',

  -- client-go
  '"k8s.io/client-go/rest"',
  'clientgoscheme "k8s.io/client-go/kubernetes/scheme"',
}

local kubebuilder_markers = {
  {
    label = "kubebuilder:marker validation enum",
    insertText = "// +kubebuilder:validation:Enum=${0:item1;item2;item3}",
    description = [[
      [Source](https://book.kubebuilder.io/reference/markers.html#markers-for-configcode-generation)
      // +kubebuilder:validation:Enum=Wallace;Gromit;Chicken
    ]]
  },
  {
    label = "kubebuilder:marker validation maximum",
    insertText = "// +kubebuilder:validation:Maximum=${0:17}",
    description = [[
      [Source](https://book.kubebuilder.io/reference/markers.html#markers-for-configcode-generation)
      // +kubebuilder:validation:Maximum=17
    ]]
  },
  {
    label = "kubebuilder:marker validation minimum",
    insertText = "// +kubebuilder:validation:Minimum=${0:0}",
    description = [[ **On Field**
      // +kubebuilder:validation:Mimimum=0
      [Source](https://book.kubebuilder.io/reference/markers.html#markers-for-configcode-generation)
    ]]
  },
  {
    label = "kubebuilder:marker validation minlength",
    insertText = "// +kubebuilder:validation:MinLength=${0:1}",
    description = [[ On Field
    specifies the minimum length for this string.
    ]]

  }
  -- "// +kubebuilder:validation:Maximum=${0:17}",
  -- " ",
}

local items = {}

for i in ipairs(common_go_imports) do
  table.insert(items, i, { label = common_go_imports[i], insertText = common_go_imports[i] })
end

for i in ipairs(kubebuilder_markers) do
  -- [information source](https://github.com/hrsh7th/nvim-cmp/blob/e1f1b40790a8cb7e64091fb12cc5ffe350363aa0/lua/cmp/entry.lua#L117)
  table.insert(items, i, {
    label = kubebuilder_markers[i].label,
    insertText = kubebuilder_markers[i].insertText,
    insertTextFormat = require('cmp.types').lsp.InsertTextFormat.Snippet,
    -- documentation = kubebuilder_markers[i].description,
    detail = kubebuilder_markers[i].description,
  })
end

source.new = function()
  local self = setmetatable({}, { _index = source })
  self.items = items
  return self
end

-- source.get_keyword_pattern = function()
--   return "im-"
-- end

source.is_available = function()
  return vim.bo.filetype == "go"
end

source.complete = function(self, _params, callback)
  callback({ items = items, isIncomplete = false })
end

return source
