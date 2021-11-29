


# Note: this is a hideous temporary file that makes no sense. Look away.




#
# twu = [t]ail[w]ind [u]utils
# Put all tailwind classes here (tedious, but might help with optimising).
# UPPERCASE = combinations of classes, used for consistency when reusing.
#

(import /lib/tw)

(def APP-BACKGROUND-COLOUR (tw/class " bg-gray-100 "))
(def CV-HEADER             (tw/class " text-lg font-semibold mt-3.5 mb-1 uppercase "))
(def INPUT-FIELD-SHARED    (tw/class " px-2 py-1 relative rounded text-sm border outline-none focus:outline-none focus:ring "))
(def INPUT-FIELD           (tw/class (string INPUT-FIELD-SHARED " border-solid  placeholder-gray-400 text-gray-600 bg-white ")))
(def INPUT-FIELD-DISABLED  (tw/class (string INPUT-FIELD-SHARED " border-dashed placeholder-gray-400 text-gray-600 bg-gray-100 ")))




(def bg-blue-400           (tw/class "bg-blue-400"))
(def bg-green-500          (tw/class "bg-green-500"))
(def bg-purple-400         (tw/class "bg-purple-400"))
(def bg-red-400            (tw/class "bg-red-400"))
(def bg-white              (tw/class "bg-white"))
(def border                (tw/class "border"))
(def border-2              (tw/class "border-2"))
(def border-dashed         (tw/class "border-dashed"))
(def border-light-blue-500 (tw/class "border-light-blue-500"))
(def border-t-2            (tw/class "border-t-2"))
(def break-words           (tw/class "break-words"))
(def container             (tw/class "container"))
(def content-center        (tw/class "content-center"))
(def cursor-pointer        (tw/class "cursor-pointer"))
(def flex                  (tw/class "flex"))
(def flex-1                (tw/class "flex-1"))
(def flex-row              (tw/class "flex-row"))
(def float-right           (tw/class "float-right"))
(def focus:outline-none    (tw/class "focus:outline-none"))
(def font-medium           (tw/class "font-medium"))
(def font-semibold         (tw/class "font-semibold"))
(def grid                  (tw/class "grid"))
(def h-4                   (tw/class "h-4"))
(def h-5                   (tw/class "h-5"))
(def h-6                   (tw/class "h-6"))
(def inline-block          (tw/class "inline-block"))
(def items-center          (tw/class "items-center"))
(def items-stretch         (tw/class "items-stretch"))
(def justify-center        (tw/class "justify-center"))
(def justify-items-stretch (tw/class "justify-items-stretch"))
(def m-2                   (tw/class "m-2"))
(def mb-4                  (tw/class "mb-4"))
(def md:flex               (tw/class "md:flex"))
(def md:justify-center     (tw/class "md:justify-center"))
(def ml-0                  (tw/class "ml-0"))
(def ml-8                  (tw/class "ml-8"))
(def mr-1                  (tw/class "mr-1"))
(def mr-2                  (tw/class "mr-2"))
(def mt-2                  (tw/class "mt-2"))
(def mx-auto               (tw/class "mx-auto"))
(def outline-none          (tw/class "outline-none"))
(def overflow-x-auto       (tw/class "overflow-x-auto"))
(def overflow-x-scroll     (tw/class "overflow-x-scroll"))
(def p-1                   (tw/class "p-1"))
(def p-2                   (tw/class "p-2"))
(def p-3                   (tw/class "p-3"))
(def p-4                   (tw/class "p-4"))
(def pt-1                  (tw/class "pt-1"))
(def pt-3                  (tw/class "pt-3"))
(def px-1                  (tw/class "px-1"))
(def px-2                  (tw/class "px-2"))
(def px-3                  (tw/class "px-3"))
(def py-1                  (tw/class "py-1"))
(def py-2                  (tw/class "py-2"))
(def rounded               (tw/class "rounded"))
(def rounded-lg            (tw/class "rounded-lg"))
(def rounded-md            (tw/class "rounded-md"))
(def select-none           (tw/class "select-none"))
(def text-base             (tw/class "text-base"))
(def text-blue-500         (tw/class "text-blue-500"))
(def text-center           (tw/class "text-center"))
(def text-gray-700         (tw/class "text-gray-700"))
(def text-lg               (tw/class "text-lg"))
(def text-red-500          (tw/class "text-red-500"))
(def text-sm               (tw/class "text-sm"))
(def text-white            (tw/class "text-white"))
(def text-xs               (tw/class "text-xs"))
(def w-1/3                 (tw/class "w-1/3"))
(def w-5                   (tw/class "w-5"))
(def w-full                (tw/class "w-full"))
