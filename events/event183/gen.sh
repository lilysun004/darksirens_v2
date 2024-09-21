lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.486246246246246 --fixed-mass2 27.497257257257257 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017904677.3995589 \
--gps-end-time 1017911877.3995589 \
--d-distr volume \
--min-distance 436.07635602332607e3 --max-distance 436.09635602332605e3 \
--l-distr fixed --longitude 162.82484436035156 --latitude -19.224027633666992 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
