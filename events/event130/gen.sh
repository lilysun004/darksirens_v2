lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.117197197197196 --fixed-mass2 36.65805805805806 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014437562.7660725 \
--gps-end-time 1014444762.7660725 \
--d-distr volume \
--min-distance 675.1730121428348e3 --max-distance 675.1930121428347e3 \
--l-distr fixed --longitude 1.4520081281661987 --latitude -14.937172889709473 --i-distr uniform \
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
