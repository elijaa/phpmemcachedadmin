<?php
/**
 * Copyright 2010 Cyrille Mahieux
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and limitations
 * under the License.
 *
 * ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°> ><)))°>
 *
 * Object to store stats
 *
 * @author c.mahieux@of2m.fr
 * @since 16/04/2010
 */
class Library_Data_Stats extends Library_Data_Abstract
{
    /**
     * Add additional analysis to stats
     *
     * @return void
     */
    public function analyse()
    {
        # Adding missing stats
        $this->_data['cmd_delete'] = $this->_data['delete_hits'] + $this->_data['delete_misses'];
        $this->_data['cmd_cas'] = $this->_data['cas_hits'] + $this->_data['cas_misses'] + $this->_data['cas_badval'];
        $this->_data['cmd_incr'] = $this->_data['incr_hits'] + $this->_data['incr_misses'];
        $this->_data['cmd_decr'] = $this->_data['decr_hits'] + $this->_data['decr_misses'];
        $this->_data['cmd_total'] = $this->_data['cmd_get'] + $this->_data['cmd_set'] + $this->_data['cmd_delete'] + $this->_data['cmd_cas'] + $this->_data['cmd_incr'] + $this->_data['cmd_decr'];
    }
}