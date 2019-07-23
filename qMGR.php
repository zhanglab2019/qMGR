<?
/**
 * $benchmark arr
 * $species   string
 */
function getResult($benchmark, $species){
    $specie    = explode(PHP_EOL,$species);
    foreach($specie as $k=>$v){
        if(trim($v) == ''){
            unset($specie[$k]); 
        }
    }
    $specie    = array_values($specie);
    
    $sname     = array();
    $sval      = array();
    foreach($specie as $k=>$v){
        if($k%2==0){
            $sname[($k/2)+1]  = $v;
        }else{
            $sval[($k+1)/2]   = $v;
        }
    }

    $cnt    = 0;
    foreach($sval as $sk=>$sv){
        $specie    = explode(',',$sv);
        $cnt    += $specie[0];
        foreach($benchmark as $k=>$v){
            //统计个数
            $kk = arr_counts(trim($v), $specie);
            // print_r($kk);
            $vcnt   = count($kk);
            if($vcnt == 0){
                $res[$v]    = 2;
            }
            else{
                $sum = 0;
                // print_r($specie);
                // echo count($specie);
                foreach($kk as $z=>$kv){
                    if($kv == 1){
                        $s_n    = 2;
                        $s_p    = count($specie)-1;
                    }elseif($kv == count($specie)-1){
                        $s_n    = 1;
                        $s_p    = $kv-1;
                    }else{
                        $s_n    = $kv+1;
                        $s_p    = $kv-1;
                    }

                    if($k == 0){
                        $k_n    = 1;
                        $k_p    = count($benchmark)-1;
                    }elseif($k == count($benchmark)-1){
                        $k_n    = 0;
                        $k_p    = $k-1;
                    }else{
                        $k_n    = $k+1;
                        $k_p    = $k-1;
                    }

                    
                    if(trim($benchmark[$k_n]) != trim($specie[$s_n])){
                        $sum++;
                    }
                    if(trim($benchmark[$k_p]) != trim($specie[$s_p])){
                        $sum++;
                    }
                    $res[$v]    = $sum;

                }
            }
        }

        $count[$sk] = $specie[0];
        $result[$sk] = $res;
        $rs[trim(str_replace('>','',$sname[$sk]))] = array_sum($res);
    }
    $data = array('result'=>$result, 'count'=>$count, 'rs'=>$rs, 'cnt'=>$cnt);
    // echo '<pre/>';
    // print_r($data);
    return $data;
}

// 统计数组中某个值的个数
function arr_count($val, $arr){
    $sum = 0;
    foreach($arr as $k=>$v){
        if($val == $v){
            $sum++;
        }
    }
    return $sum;
}

// 统计数组中某个值的位置
function arr_counts($val, $arr){
    $kk = array();
    for($i=0; $i<count($arr); $i++){
        if($val == trim($arr[$i])){
            array_push($kk, $i);
        }
    }
    return $kk;
}



