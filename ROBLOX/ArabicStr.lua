local Strings = {'ض','ص','ث','ق','ف','غ','ع','ه','خ','ح','ج','د','ش','س','ي','ب','ل','لا','ت','ن','م','ك','ك','ط','ئ','ء','ؤ','ر','لا','لى','ة','ة','و','ز','ظ'}

function GetStr(length)
    local length = length or 10
    local Str = ''
    for i = 1, length do
        Str = Str .. Strings[math.random(1, #Strings)]
    end
    return Str
end